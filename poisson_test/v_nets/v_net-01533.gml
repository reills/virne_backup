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
  id 1533
  arrival_time 33966.277388185765
  lifetime 215.9449356894702
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 23
    gpu 42
    rom 20
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 48
    rom 28
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 23
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 16
    gpu 5
    rom 23
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 45
    rom 39
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 10
    rom 12
  ]
  node [
    id 6
    label "6"
    cpu 31
    gpu 26
    rom 46
  ]
  node [
    id 7
    label "7"
    cpu 45
    gpu 38
    rom 14
  ]
  node [
    id 8
    label "8"
    cpu 31
    gpu 10
    rom 38
  ]
  node [
    id 9
    label "9"
    cpu 6
    gpu 27
    rom 44
  ]
  node [
    id 10
    label "10"
    cpu 30
    gpu 6
    rom 33
  ]
  node [
    id 11
    label "11"
    cpu 47
    gpu 23
    rom 31
  ]
  node [
    id 12
    label "12"
    cpu 3
    gpu 36
    rom 12
  ]
  edge [
    source 0
    target 1
    bw 49
  ]
  edge [
    source 1
    target 2
    bw 13
  ]
  edge [
    source 2
    target 3
    bw 7
  ]
  edge [
    source 3
    target 4
    bw 18
  ]
  edge [
    source 4
    target 5
    bw 39
  ]
  edge [
    source 5
    target 6
    bw 13
  ]
  edge [
    source 6
    target 7
    bw 33
  ]
  edge [
    source 7
    target 8
    bw 43
  ]
  edge [
    source 8
    target 9
    bw 19
  ]
  edge [
    source 9
    target 10
    bw 13
  ]
  edge [
    source 10
    target 11
    bw 13
  ]
  edge [
    source 11
    target 12
    bw 39
  ]
]
