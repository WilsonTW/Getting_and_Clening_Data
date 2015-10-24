## Variables
==========================================
1. `x_train`, `y_train`, `x_test`, `y_test`, `subject_train` and `subject_test` contain the data from the downloaded files.
2. `x_data`, `y_data` and `subject_data` merge the previous datasets to be compact datasets.
3. `features` contains the correct names for the `x_data` dataset, which are applied to the column names stored in `mean_and_std`.
4. `activity_labels` contains activity names in it.
5. `combind_data` merges `x_data`, `y_data` and `subject_data` to be a big dataset.
6. `average` contains the averages stored in a `.txt` file.