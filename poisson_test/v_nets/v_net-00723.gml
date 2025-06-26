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
  id 723
  arrival_time 15277.161148926665
  lifetime 20.595097788546934
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 17
    rom 7
  ]
  node [
    id 1
    label "1"
    cpu 27
    gpu 1
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 10
    gpu 15
    rom 17
  ]
  node [
    id 3
    label "3"
    cpu 36
    gpu 25
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 35
    gpu 22
    rom 12
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 20
    rom 12
  ]
  node [
    id 6
    label "6"
    cpu 11
    gpu 26
    rom 50
  ]
  node [
    id 7
    label "7"
    cpu 10
    gpu 50
    rom 47
  ]
  node [
    id 8
    label "8"
    cpu 26
    gpu 4
    rom 22
  ]
  node [
    id 9
    label "9"
    cpu 42
    gpu 3
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 50
  ]
  edge [
    source 1
    target 2
    bw 33
  ]
  edge [
    source 2
    target 3
    bw 13
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
  edge [
    source 4
    target 5
    bw 16
  ]
  edge [
    source 5
    target 6
    bw 33
  ]
  edge [
    source 6
    target 7
    bw 10
  ]
  edge [
    source 7
    target 8
    bw 47
  ]
  edge [
    source 8
    target 9
    bw 13
  ]
]
