import pandas as pd
import numpy as np
import os


directory = 'C:/Users/ptbad/Desktop/practiques_fenomens/FCTF_tardor_2022/final/data_exes/data'

check = True

for filename in os.listdir(directory):

    f = os.path.join(directory, filename)
    
    if os.path.isfile(f):
        if check:

            columns = 'L TEMP SUM SUME SUME2 VARE SUMM SUMAM SUMM2 VARM DELTAE DELTAT'
            data = pd.read_csv(f, header = None, delim_whitespace=True, names = columns.split(' '))
            check = False

        else:

            new_data = pd.read_csv(f, header = None, delim_whitespace=True, names = columns.split(' '))
            data = pd.concat(data, new_data)


data_matrix = np.array(data.sort_values(by=['L','TEMP']))

empty = np.array([[]])

with open("processed_pau_torrente_badia.txt", "ab") as f:

    for L in range(12,84,12):
        
        data_matrix_byL = data_matrix[data_matrix[:, 0] == L, :]
        np.savetxt(f, data_matrix_byL)
        np.savetxt(f, empty)
        np.savetxt(f, empty)



