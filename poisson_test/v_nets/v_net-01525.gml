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
  id 1525
  arrival_time 33814.95561023562
  lifetime 713.4452928220586
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 26
    gpu 15
    rom 0
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 43
    rom 44
  ]
  node [
    id 2
    label "2"
    cpu 43
    gpu 37
    rom 44
  ]
  node [
    id 3
    label "3"
    cpu 17
    gpu 45
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 18
    gpu 48
    rom 42
  ]
  node [
    id 5
    label "5"
    cpu 42
    gpu 26
    rom 42
  ]
  node [
    id 6
    label "6"
    cpu 18
    gpu 6
    rom 48
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 5
  ]
  edge [
    source 2
    target 3
    bw 20
  ]
  edge [
    source 3
    target 4
    bw 13
  ]
  edge [
    source 4
    target 5
    bw 27
  ]
  edge [
    source 5
    target 6
    bw 41
  ]
]
