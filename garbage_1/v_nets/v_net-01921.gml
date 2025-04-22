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
  id 1921
  arrival_time 42157.96142234049
  lifetime 1040.4954711053872
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 26
    gpu 21
    rom 44
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 40
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 8
    rom 2
  ]
  node [
    id 3
    label "3"
    cpu 0
    gpu 30
    rom 42
  ]
  node [
    id 4
    label "4"
    cpu 6
    gpu 40
    rom 14
  ]
  node [
    id 5
    label "5"
    cpu 9
    gpu 2
    rom 8
  ]
  node [
    id 6
    label "6"
    cpu 14
    gpu 17
    rom 42
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 33
  ]
  edge [
    source 2
    target 3
    bw 1
  ]
  edge [
    source 3
    target 4
    bw 11
  ]
  edge [
    source 4
    target 5
    bw 14
  ]
  edge [
    source 5
    target 6
    bw 10
  ]
]
