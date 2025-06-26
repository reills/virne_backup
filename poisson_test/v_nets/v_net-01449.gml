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
  id 1449
  arrival_time 30578.26681354835
  lifetime 700.9806781673901
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 23
    rom 15
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 26
    rom 31
  ]
  node [
    id 2
    label "2"
    cpu 34
    gpu 26
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 36
    rom 42
  ]
  node [
    id 4
    label "4"
    cpu 1
    gpu 34
    rom 2
  ]
  node [
    id 5
    label "5"
    cpu 17
    gpu 45
    rom 21
  ]
  node [
    id 6
    label "6"
    cpu 43
    gpu 36
    rom 43
  ]
  node [
    id 7
    label "7"
    cpu 46
    gpu 43
    rom 39
  ]
  node [
    id 8
    label "8"
    cpu 37
    gpu 4
    rom 14
  ]
  node [
    id 9
    label "9"
    cpu 22
    gpu 16
    rom 47
  ]
  node [
    id 10
    label "10"
    cpu 32
    gpu 12
    rom 45
  ]
  node [
    id 11
    label "11"
    cpu 33
    gpu 43
    rom 19
  ]
  node [
    id 12
    label "12"
    cpu 44
    gpu 37
    rom 14
  ]
  edge [
    source 0
    target 1
    bw 25
  ]
  edge [
    source 1
    target 2
    bw 40
  ]
  edge [
    source 2
    target 3
    bw 30
  ]
  edge [
    source 3
    target 4
    bw 15
  ]
  edge [
    source 4
    target 5
    bw 23
  ]
  edge [
    source 5
    target 6
    bw 39
  ]
  edge [
    source 6
    target 7
    bw 6
  ]
  edge [
    source 7
    target 8
    bw 40
  ]
  edge [
    source 8
    target 9
    bw 25
  ]
  edge [
    source 9
    target 10
    bw 49
  ]
  edge [
    source 10
    target 11
    bw 21
  ]
  edge [
    source 11
    target 12
    bw 43
  ]
]
