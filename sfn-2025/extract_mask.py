#!/usr/bin/env python
"""Extract a simple brain mask from a BOLD fMRI file."""
import sys
import nibabel as nib
import numpy as np

if len(sys.argv) != 3:
    print("Usage: extract_mask.py <input_bold.nii.gz> <output_mask.nii.gz>")
    sys.exit(1)

input_file = sys.argv[1]
output_file = sys.argv[2]

# Load the BOLD image
img = nib.load(input_file)

# Create a simple mask (all ones for demo purposes)
mask = np.ones(img.shape[:3])

# Save the mask with the same affine as the input
mask_img = nib.Nifti1Image(mask, img.affine)
nib.save(mask_img, output_file)

print(f"Created mask: {output_file}")
