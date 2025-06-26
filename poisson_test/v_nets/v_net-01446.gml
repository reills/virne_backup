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
  id 1446
  arrival_time 30470.124967914533
  lifetime 0.6065056709505554
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 27
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 21
    gpu 10
    rom 43
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 43
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 49
    rom 49
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 15
    rom 50
  ]
  node [
    id 5
    label "5"
    cpu 4
    gpu 20
    rom 6
  ]
  node [
    id 6
    label "6"
    cpu 38
    gpu 33
    rom 3
  ]
  node [
    id 7
    label "7"
    cpu 31
    gpu 47
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 23
  ]
  edge [
    source 2
    target 3
    bw 29
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
  edge [
    source 4
    target 5
    bw 32
  ]
  edge [
    source 5
    target 6
    bw 7
  ]
  edge [
    source 6
    target 7
    bw 27
  ]
]
