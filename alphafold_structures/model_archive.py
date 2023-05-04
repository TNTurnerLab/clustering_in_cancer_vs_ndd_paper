#!/bin/python
# This code was given to me by ModelArchive

import pickle, json
top_ranked_id = json.load(open("ranking_debug.json"))["order"][0]
pkl_path = f"result_{top_ranked_id}.pkl"
model_data_full = pickle.load(open(pkl_path, "rb"))
model_data = {k: model_data_full[k]
              for k in ['predicted_aligned_error', 'plddt',
                        'max_predicted_aligned_error',
                        'ptm', 'iptm', 'ranking_confidence'] \
              if k in model_data_full}
pickle.dump(model_data, open("ranked_0.pkl", "wb"))
