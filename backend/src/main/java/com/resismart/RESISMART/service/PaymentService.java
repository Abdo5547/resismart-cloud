package com.resismart.RESISMART.service;

import com.resismart.RESISMART.dto.PaymentDTO;
import com.resismart.RESISMART.models.Payment;
import com.resismart.RESISMART.models.Resident;
import com.resismart.RESISMART.repository.PaymentRepository;
import com.resismart.RESISMART.statistique.PaymentStats;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class PaymentService {

    @Autowired
    private PaymentRepository paymentRepository;

    // Récupérer un paiement par son identifiant
 

    public void markPaymentAsPaid(Integer paymentId) {
        Payment payment = paymentRepository.findById(paymentId)
            .orElseThrow(() -> new RuntimeException("Paiement introuvable"));

        // Vérifie si le résident paie le jour même
        LocalDate paymentDate = payment.getDatePayment().toLocalDate();
        if (ChronoUnit.DAYS.between(paymentDate, LocalDate.now()) == 0) {
            return; // Pas de changement si payé le même jour
        }

        // Met à jour le statut comme payé
        payment.markAsPaid();
        paymentRepository.save(payment);
    }



    // Compter le nombre de paiements pour un résident donné
    public long countPaymentsByResident(Resident resident) {
        return paymentRepository.countByResident(resident);
    }

   

        public List<PaymentDTO> getAllPayments() {
        List<Payment> payments = paymentRepository.findAll();

        // Convertir les Payment en PaymentDTO
        return payments.stream()
                       .map(PaymentDTO::new)
                       .collect(Collectors.toList());

                       
    }


    public List<PaymentDTO> getPaymentsByResident(Resident resident) {
        List<Payment> payments = paymentRepository.findByResident(resident);

        // Convertir les Payment en PaymentDTO
        return payments.stream()
        .map(PaymentDTO::new)
        .collect(Collectors.toList());
     
            }




    public PaymentStats getPaymentStatistics() {
        List<Payment> payments = paymentRepository.findAll();

        List<Double> completedPayments = payments.stream()
                .filter(payment -> "Paid".equals(payment.getStatus()))
                .map(Payment::getAmount)
                .collect(Collectors.toList());

        List<Double> pendingPayments = payments.stream()
                .filter(payment -> "PendingPayment".equals(payment.getStatus()))
                .map(Payment::getAmount)
                .collect(Collectors.toList());

        List<Double> latePayments = payments.stream()
                .filter(payment -> "LatePayment".equals(payment.getStatus()))
                .map(Payment::getAmount)
                .collect(Collectors.toList());

        return new PaymentStats(completedPayments, pendingPayments,latePayments);
    }


}
