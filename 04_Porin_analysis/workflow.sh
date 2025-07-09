iqtree2 -s Porin_alignment.clustalo.faa -m MF --mset LG,WAG,JTT,Q.pfam,JTTDCMut,DCMut,VT,PMB,Blosum62,Dayhoff -T 4 --prefix Porin_model # Determine the best fit model and use it for the next step
best_model=$(grep 'Best-fit' Porin_model.log | cut -f3 -d' ')
echo "Best model extracted: $best_model" # Q.pfam+F+G4
iqtree2 -s Porin_alignment.clustalo.faa -m $best_model --alrt 1000 -B 1000 -T 4 --prefix Porin_phylogeny # Create the final phylogeny
