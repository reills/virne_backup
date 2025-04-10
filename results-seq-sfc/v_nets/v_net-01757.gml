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
  id 1757
  arrival_time 39136.96045893088
  lifetime 2707.560459737817
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 4
    gpu 1
    rom 12
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 26
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 14
    gpu 47
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 31
    rom 36
  ]
  node [
    id 4
    label "4"
    cpu 35
    gpu 29
    rom 5
  ]
  node [
    id 5
    label "5"
    cpu 49
    gpu 32
    rom 19
  ]
  edge [
    source 0
    target 1
    bw 49
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 14
  ]
  edge [
    source 3
    target 4
    bw 3
  ]
  edge [
    source 4
    target 5
    bw 8
  ]
]
