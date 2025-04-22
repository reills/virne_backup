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
  id 407
  arrival_time 8036.993418785791
  lifetime 725.4413092805052
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 35
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 23
    gpu 42
    rom 42
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 29
    rom 26
  ]
  node [
    id 3
    label "3"
    cpu 24
    gpu 7
    rom 18
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 46
    rom 28
  ]
  node [
    id 5
    label "5"
    cpu 36
    gpu 47
    rom 29
  ]
  node [
    id 6
    label "6"
    cpu 12
    gpu 18
    rom 43
  ]
  node [
    id 7
    label "7"
    cpu 26
    gpu 23
    rom 16
  ]
  node [
    id 8
    label "8"
    cpu 29
    gpu 7
    rom 50
  ]
  node [
    id 9
    label "9"
    cpu 34
    gpu 18
    rom 23
  ]
  node [
    id 10
    label "10"
    cpu 34
    gpu 23
    rom 28
  ]
  node [
    id 11
    label "11"
    cpu 49
    gpu 28
    rom 31
  ]
  node [
    id 12
    label "12"
    cpu 31
    gpu 11
    rom 19
  ]
  node [
    id 13
    label "13"
    cpu 31
    gpu 31
    rom 12
  ]
  node [
    id 14
    label "14"
    cpu 32
    gpu 13
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 30
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 23
  ]
  edge [
    source 3
    target 4
    bw 8
  ]
  edge [
    source 4
    target 5
    bw 35
  ]
  edge [
    source 5
    target 6
    bw 43
  ]
  edge [
    source 6
    target 7
    bw 30
  ]
  edge [
    source 7
    target 8
    bw 11
  ]
  edge [
    source 8
    target 9
    bw 45
  ]
  edge [
    source 9
    target 10
    bw 39
  ]
  edge [
    source 10
    target 11
    bw 48
  ]
  edge [
    source 11
    target 12
    bw 33
  ]
  edge [
    source 12
    target 13
    bw 24
  ]
  edge [
    source 13
    target 14
    bw 11
  ]
]
