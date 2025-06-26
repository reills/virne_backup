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
  id 1912
  arrival_time 42072.12832743329
  lifetime 293.89875525598023
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 14
    gpu 14
    rom 9
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 41
    rom 40
  ]
  node [
    id 2
    label "2"
    cpu 12
    gpu 33
    rom 39
  ]
  node [
    id 3
    label "3"
    cpu 4
    gpu 15
    rom 36
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 18
    rom 11
  ]
  node [
    id 5
    label "5"
    cpu 13
    gpu 13
    rom 46
  ]
  node [
    id 6
    label "6"
    cpu 6
    gpu 33
    rom 12
  ]
  node [
    id 7
    label "7"
    cpu 9
    gpu 37
    rom 2
  ]
  node [
    id 8
    label "8"
    cpu 15
    gpu 8
    rom 4
  ]
  node [
    id 9
    label "9"
    cpu 3
    gpu 15
    rom 47
  ]
  edge [
    source 0
    target 1
    bw 40
  ]
  edge [
    source 1
    target 2
    bw 25
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
    bw 2
  ]
  edge [
    source 5
    target 6
    bw 14
  ]
  edge [
    source 6
    target 7
    bw 14
  ]
  edge [
    source 7
    target 8
    bw 29
  ]
  edge [
    source 8
    target 9
    bw 43
  ]
]
