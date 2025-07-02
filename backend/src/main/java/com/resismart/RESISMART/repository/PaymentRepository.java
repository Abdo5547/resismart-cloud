package com.resismart.RESISMART.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.resismart.RESISMART.models.Payment;
import com.resismart.RESISMART.models.Resident;
import java.util.List;
import java.util.Optional;


@Repository
public interface PaymentRepository extends JpaRepository<Payment, Integer> {

    // Trouver un paiement par son identifiant
    Optional<Payment> findById(Integer id);

    // Trouver tous les paiements associés à un résident spécifique
    List<Payment> findByResident(Resident resident);

    // Trouver tous les paiements associés à un résident spécifique par son ID
    List<Payment> findByResidentId(Integer residentId);


    // Compter le nombre de paiements pour un résident donné
    long countByResident(Resident resident);

    // Vérifier si un paiement existe avec un identifiant spécifique
    boolean existsById(Integer id);


    // Trouver tous les paiements par statut
    List<Payment> findByStatus(String status);

    // Trouver tous les paiements non réglés (isSet = false)
    List<Payment> findByIsSetFalse();


}
