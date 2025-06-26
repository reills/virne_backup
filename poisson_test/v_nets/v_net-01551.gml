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
  id 1551
  arrival_time 34199.008795934045
  lifetime 112.71786089297733
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 42
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 18
    rom 44
  ]
  node [
    id 2
    label "2"
    cpu 13
    gpu 19
    rom 34
  ]
  node [
    id 3
    label "3"
    cpu 47
    gpu 34
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 35
    gpu 10
    rom 22
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 22
    rom 11
  ]
  node [
    id 6
    label "6"
    cpu 2
    gpu 2
    rom 35
  ]
  node [
    id 7
    label "7"
    cpu 50
    gpu 41
    rom 9
  ]
  edge [
    source 0
    target 1
    bw 14
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
  edge [
    source 4
    target 5
    bw 13
  ]
  edge [
    source 5
    target 6
    bw 8
  ]
  edge [
    source 6
    target 7
    bw 26
  ]
]
