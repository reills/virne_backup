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
  id 1147
  arrival_time 23941.271346294154
  lifetime 571.2129948135457
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 0
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 15
    gpu 41
    rom 0
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 28
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 28
    gpu 13
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 1
    gpu 23
    rom 7
  ]
  node [
    id 5
    label "5"
    cpu 37
    gpu 22
    rom 16
  ]
  edge [
    source 0
    target 1
    bw 25
  ]
  edge [
    source 1
    target 2
    bw 36
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 29
  ]
  edge [
    source 4
    target 5
    bw 48
  ]
]
