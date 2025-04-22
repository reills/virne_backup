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
  id 1735
  arrival_time 38767.646099681995
  lifetime 701.8281602793606
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 14
    gpu 13
    rom 39
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 13
    rom 42
  ]
  node [
    id 2
    label "2"
    cpu 50
    gpu 13
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 50
    gpu 26
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 21
    gpu 32
    rom 4
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 47
    rom 46
  ]
  node [
    id 6
    label "6"
    cpu 16
    gpu 44
    rom 28
  ]
  node [
    id 7
    label "7"
    cpu 22
    gpu 31
    rom 18
  ]
  node [
    id 8
    label "8"
    cpu 22
    gpu 12
    rom 20
  ]
  node [
    id 9
    label "9"
    cpu 40
    gpu 3
    rom 11
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 46
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 0
  ]
  edge [
    source 4
    target 5
    bw 48
  ]
  edge [
    source 5
    target 6
    bw 16
  ]
  edge [
    source 6
    target 7
    bw 49
  ]
  edge [
    source 7
    target 8
    bw 26
  ]
  edge [
    source 8
    target 9
    bw 48
  ]
]
