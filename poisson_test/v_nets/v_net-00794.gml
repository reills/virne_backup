graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 794
  arrival_time 16622.755846434582
  lifetime 2356.0459438104585
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 33
    gpu 40
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 34
    gpu 21
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 32
    gpu 49
    rom 21
  ]
  edge [
    source 0
    target 1
    bw 50
  ]
  edge [
    source 1
    target 2
    bw 15
  ]
]
