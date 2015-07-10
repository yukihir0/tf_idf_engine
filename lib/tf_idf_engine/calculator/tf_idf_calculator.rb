# coding: utf-8
require 'singleton'

# t_o:    term occurrence
# d_o:    document occurrence
# tf:     term frequency
# idf:    inverse document frequency
# tf_idf: tf * idf

module TfIdfEngineCalculator
  class TfIdfCalculator
    include Singleton

    public
    def term_occurrence(doc)
      doc.inject(Hash.new(0)) { |t_o, term|
        t_o[term] += 1
        t_o
      }
    end

    def total_term(t_o)
      count_list = t_o.values
      count_list.inject(0) { |total, count|
        total += count
        total
      }
    end

    def term_frequency(t_o)
      total = total_term(t_o).to_f

      term_list = t_o.keys
      term_list.inject(Hash.new(0)) { |tf, term|
        tf[term] = t_o[term] / total
        tf
      }
    end

    def term_frequency_all(t_o_all)
      id_list = t_o_all.keys
      id_list.inject(Hash.new) { |tf_all, id|
        t_o = t_o_all[id]
        tf_all[id] = term_frequency(t_o)
        tf_all 
      }
    end

    def total_doc(t_o_all)
      t_o_all.keys.length
    end

    def doc_occurrence(t_o_all)
      t_o_list = t_o_all.values
      t_o_list.inject(Hash.new(0)) { |d_o, t_o|
        t_o.each_key { |term|
          d_o[term] += 1
        }
        d_o
      }
    end

    def inverse_document_frequency(t_o_all)
      unprocessed_doc = false

      total = total_doc(t_o_all).to_f
      d_o   = doc_occurrence(t_o_all)

      idf = Hash.new 
      d_o.each { |term, count|
        idf[term] = Math::log10(total / count)
      }
      idf
    end

    def tf_idf(tf_all, idf_all)
      tf_idf_all = Hash.new 

      tf_all.each { |id, tf|
        tf_idf = Hash.new
        tf.each { |term, frequency|
          tf_idf[term] = frequency * idf_all[term]
        }
        tf_idf_all[id] = tf_idf 
      }
      tf_idf_all
    end
  end
end
