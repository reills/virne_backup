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
  id 1655
  arrival_time 37027.57698695653
  lifetime 346.18708571327437
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 3
    gpu 11
    rom 14
  ]
  node [
    id 1
    label "1"
    cpu 1
    gpu 21
    rom 49
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 7
    rom 26
  ]
  node [
    id 3
    label "3"
    cpu 37
    gpu 4
    rom 5
  ]
  node [
    id 4
    label "4"
    cpu 17
    gpu 3
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 29
    gpu 36
    rom 8
  ]
  node [
    id 6
    label "6"
    cpu 13
    gpu 29
    rom 38
  ]
  node [
    id 7
    label "7"
    cpu 21
    gpu 8
    rom 40
  ]
  node [
    id 8
    label "8"
    cpu 5
    gpu 18
    rom 39
  ]
  node [
    id 9
    label "9"
    cpu 8
    gpu 30
    rom 19
  ]
  node [
    id 10
    label "10"
    cpu 3
    gpu 4
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 48
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
  edge [
    source 4
    target 5
    bw 32
  ]
  edge [
    source 5
    target 6
    bw 5
  ]
  edge [
    source 6
    target 7
    bw 15
  ]
  edge [
    source 7
    target 8
    bw 19
  ]
  edge [
    source 8
    target 9
    bw 22
  ]
  edge [
    source 9
    target 10
    bw 22
  ]
]
