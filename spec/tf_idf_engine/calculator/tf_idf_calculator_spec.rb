# coding: utf-8
require File.expand_path('spec/spec_helper')
include Calculator

describe TfIdfCalculator do
    context 'initialized' do
        before(:each) do
            @calculator = TfIdfCalculator.instance
        end

        describe "#term_occurrence" do
            where(:doc, :expected_t_o) do
                [
                    [%w(), {}],
                    [%w(a), {'a' => 1}],
                    [%w(a a), {'a' => 2}],
                    [%w(a b), {'a' => 1, 'b' => 1}],
                    [%w(a b a), {'a' => 2, 'b' => 1}],
                    [%w(a b c), {'a' => 1, 'b' => 1, 'c' => 1}]
                ]
            end
            with_them do
                it "expected t_o" do
                    t_o = @calculator.term_occurrence(doc)
                    t_o.should == expected_t_o
                end
            end
        end

        describe '#total_term' do
            where(:t_o, :expected_total_term) do
                [
                    [{}, 0],
                    [{'a' => 1}, 1],
                    [{'a' => 2}, 2],
                    [{'a' => 1, 'b' => 1}, 2],
                    [{'a' => 2, 'b' => 1}, 3],
                    [{'a' => 1, 'b' => 1, 'c' => 1}, 3]
                ]
            end
            with_them do
                it 'expected total term' do
                    total_term = @calculator.total_term(t_o)
                    total_term.should == expected_total_term
                end
            end
        end
        
        describe '#term_frequenry' do
            where(:t_o, :expected_tf) do
                [
                    [{}, {}],
                    [{'a' => 1}, {'a' => 1.0}],
                    [{'a' => 2}, {'a' => 1.0}],
                    [{'a' => 1, 'b' => 1}, {'a' => 0.5, 'b' => 0.5}],
                    [{'a' => 2, 'b' => 1}, {'a' => 2.0/3, 'b' => 1.0/3}],
                    [{'a' => 2, 'b' => 2}, {'a' => 0.5, 'b' => 0.5}],
                    [{'a' => 1, 'b' => 1, 'c' => 1}, {'a' => 1.0/3, 'b' => 1.0/3, 'c' => 1.0/3}]
                ]
            end
            with_them do
                it 'expected tf' do
                    tf = @calculator.term_frequency(t_o)
                    tf.should == expected_tf
                end
            end
        end
        
        describe '#term_frequency_all' do
            where(:t_o_all, :expected_tf_all) do
                [
                    [{'id_001' => {}},
                     {'id_001' => {}}
                    ],
                    [{'id_001' => {'a' => 1}},
                     {'id_001' => {'a' => 1.0}}
                    ],
                    [{'id_001' => {'a' => 1, 'b' => 1}},
                     {'id_001' => {'a' => 0.5, 'b' => 0.5}}
                    ],
                    [{'id_001' => {'a' => 1}, 'id_002' => {'a' => 1}},
                     {'id_001' => {'a' => 1.0}, 'id_002' => {'a' => 1.0}}
                    ],
                    [{'id_001' => {'a' => 1, 'b' => 1}, 'id_002' => {'a' => 1}},
                     {'id_001' => {'a' => 0.5, 'b' => 0.5}, 'id_002' => {'a' => 1.0}}
                    ],
                    [{'id_001' => {'a' => 1}, 'id_002' => {'b' => 1}, 'id3' => {'c' => 1}},
                     {'id_001' => {'a' => 1.0}, 'id_002' => {'b' => 1.0}, 'id3' => {'c' => 1.0}}
                    ]
                ]
            end
            with_them do
                it 'expected tf_all' do
                    tf_all = @calculator.term_frequency_all(t_o_all)
                    tf_all.should == expected_tf_all
                end
            end
        end

        describe '#total_doc' do
            where(:t_o_all, :expected_total_doc) do
                [
                    [{'id_001' => {}}, 1],
                    [{'id_001' => {'a' => 1}}, 1],
                    [{'id_001' => {'a' => 1, 'b' => 1}}, 1],
                    [{'id_001' => {'a' => 1}, 'id_002' => {'a' => 1}}, 2],
                    [{'id_001' => {'a' => 1, 'b' => 1}, 'id_002' => {'a' => 1}}, 2],
                    [{'id_001' => {'a' => 1}, 'id_002' => {'b' => 1}, 'id3' => {'c' => 1}}, 3]
                ]
            end
            with_them do
                it 'expected' do
                    total_doc = @calculator.total_doc(t_o_all)
                    total_doc.should == expected_total_doc
                end
            end
        end

        describe '#doc_occurrence' do
            where(:t_o_all, :expected_d_o) do
                [
                    [{'id_001' => {}},
                     {}
                    ],
                    [{'id_001' => {'a' => 1}},
                     {'a' => 1}
                    ],
                    [{'id_001' => {'a' => 1, 'b' => 1}},
                     {'a' => 1, 'b' => 1}
                    ],
                    [{'id_001' => {'a' => 1}, 'id_002' => {'a' => 1}},
                     {'a' => 2}
                    ],
                    [{'id_001' => {'a' => 1, 'b' => 1}, 'id_002' => {'a' => 1}},
                     {'a' => 2, 'b' => 1}
                    ],
                    [{'id_001' => {'a' => 1}, 'id_002' => {'b' => 1}, 'id3' => {'c' => 1}},
                     {'a' => 1, 'b' => 1, 'c' => 1}
                    ]
                ]
            end
            with_them do
                it 'expected d_o' do
                    d_o = @calculator.doc_occurrence(t_o_all)
                    d_o.should == expected_d_o
                end
            end
        end

        describe '#inverse_document_frequency' do
            where(:t_o_all, :expected_idf) do
                [
                    [{'id_001' => {}},
                     {}
                    ],
                    [{'id_001' => {'a' => 1}},
                     {'a' => 0.0}
                    ],
                    [{'id_001' => {'a' => 1, 'b' => 1}},
                     {'a' => 0.0, 'b' => 0.0}
                    ],
                    [{'id_001' => {'a' => 1}, 'id_002' => {'a' => 1}},
                     {'a' => 0.0}
                    ],
                    [{'id_001' => {'a' => 1, 'b' => 1}, 'id_002' => {'a' => 1}},
                     {'a' => 0.0, 'b' => Math::log10(2/1)}
                    ],
                    [{'id_001' => {'a' => 1}, 'id_002' => {'b' => 1}, 'id3' => {'c' => 1}},
                     {'a' => Math::log10(3/1), 'b' => Math::log10(3/1), 'c' => Math::log10(3/1)}
                    ],
                    [{'id_001' => {'a' => 8, 'b' => 2}, 'id_002' => {'a' => 2}},
                     {'a' => 0.0, 'b' => Math::log10(2/1)}
                    ]
                ]
            end
            with_them do
                it 'expected idf' do
                    idf = @calculator.inverse_document_frequency(t_o_all)
                    idf.should == expected_idf
                end
            end
        end

        describe '#tf_idf' do
            where(:tf, :idf, :expected_tf_idf) do
                [
                    [{'id_001' => {}},
                     {},
                     {'id_001' => {}}
                    ],
                    [{'id_001' => {'a' => 1}},
                     {'a' => 0.0},
                     {'id_001' => {'a' => 0.0}}
                    ],
                    [{'id_001' => {'a' => 2}},
                     {'a' => Math::log10(1)},
                     {'id_001' => {'a' => 0.0}}
                    ],
                    [{'id_001' => {'a' => 0.5, 'b' => 0.5}},
                     {'a' => 0.0, 'b' => 0.0},
                     {'id_001' => {'a' => 0.0, 'b' => 0.0}}
                    ],
                    [{'id_001' => {'a' => 1.0}, 'id_002' => {'a' => 1.0}},
                     {'a' => 0.0},
                     {'id_001' => {'a' => 0.0}, 'id_002' => {'a' => 0.0}}
                    ],
                    [{'id_001' => {'a' => 0.8, 'b' => 0.2}, 'id_002' => {'a' => 1.0}},
                     {'a' => 0.0, 'b' => Math::log10(2/1)},
                     {'id_001' => {'a' => 0.0, 'b' => 0.2*Math::log10(2/1)}, 'id_002' => {'a' => 0.0}}
                    ]
                ]
            end
            with_them do
                it 'expected tf_idf' do
                    tf_idf = @calculator.tf_idf(tf, idf)
                    tf_idf.should == expected_tf_idf
                end
            end
        end
    end
end
