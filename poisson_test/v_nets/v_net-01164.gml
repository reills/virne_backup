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
  id 1164
  arrival_time 24130.696190186885
  lifetime 337.8269056652428
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 28
    gpu 40
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 44
    rom 42
  ]
  node [
    id 2
    label "2"
    cpu 16
    gpu 12
    rom 12
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 31
    rom 35
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 37
    rom 14
  ]
  node [
    id 5
    label "5"
    cpu 4
    gpu 25
    rom 19
  ]
  node [
    id 6
    label "6"
    cpu 40
    gpu 32
    rom 19
  ]
  node [
    id 7
    label "7"
    cpu 32
    gpu 7
    rom 39
  ]
  node [
    id 8
    label "8"
    cpu 24
    gpu 15
    rom 46
  ]
  node [
    id 9
    label "9"
    cpu 5
    gpu 39
    rom 25
  ]
  node [
    id 10
    label "10"
    cpu 14
    gpu 40
    rom 34
  ]
  node [
    id 11
    label "11"
    cpu 23
    gpu 31
    rom 20
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 7
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
  edge [
    source 3
    target 4
    bw 13
  ]
  edge [
    source 4
    target 5
    bw 10
  ]
  edge [
    source 5
    target 6
    bw 12
  ]
  edge [
    source 6
    target 7
    bw 32
  ]
  edge [
    source 7
    target 8
    bw 10
  ]
  edge [
    source 8
    target 9
    bw 46
  ]
  edge [
    source 9
    target 10
    bw 6
  ]
  edge [
    source 10
    target 11
    bw 47
  ]
]
