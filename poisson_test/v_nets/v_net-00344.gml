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
  id 344
  arrival_time 6530.249712921115
  lifetime 495.89524047582427
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 0
    gpu 14
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 9
    gpu 31
    rom 17
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 44
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 5
    rom 37
  ]
  node [
    id 4
    label "4"
    cpu 27
    gpu 17
    rom 2
  ]
  node [
    id 5
    label "5"
    cpu 13
    gpu 28
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 49
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 26
  ]
  edge [
    source 3
    target 4
    bw 44
  ]
  edge [
    source 4
    target 5
    bw 0
  ]
]
