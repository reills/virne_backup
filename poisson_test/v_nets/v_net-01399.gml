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
  id 1399
  arrival_time 29393.92391038434
  lifetime 586.4981029148721
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 41
    rom 6
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 27
    rom 11
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 8
    rom 10
  ]
  node [
    id 3
    label "3"
    cpu 22
    gpu 40
    rom 4
  ]
  node [
    id 4
    label "4"
    cpu 37
    gpu 25
    rom 7
  ]
  node [
    id 5
    label "5"
    cpu 28
    gpu 43
    rom 19
  ]
  node [
    id 6
    label "6"
    cpu 42
    gpu 42
    rom 8
  ]
  node [
    id 7
    label "7"
    cpu 7
    gpu 25
    rom 22
  ]
  node [
    id 8
    label "8"
    cpu 26
    gpu 0
    rom 44
  ]
  node [
    id 9
    label "9"
    cpu 6
    gpu 24
    rom 23
  ]
  edge [
    source 0
    target 1
    bw 26
  ]
  edge [
    source 1
    target 2
    bw 39
  ]
  edge [
    source 2
    target 3
    bw 38
  ]
  edge [
    source 3
    target 4
    bw 9
  ]
  edge [
    source 4
    target 5
    bw 39
  ]
  edge [
    source 5
    target 6
    bw 44
  ]
  edge [
    source 6
    target 7
    bw 40
  ]
  edge [
    source 7
    target 8
    bw 25
  ]
  edge [
    source 8
    target 9
    bw 3
  ]
]
