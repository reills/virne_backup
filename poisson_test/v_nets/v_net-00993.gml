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
  id 993
  arrival_time 21167.11929014325
  lifetime 149.90480901790792
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 19
    gpu 27
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 13
    gpu 43
    rom 2
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 47
    rom 31
  ]
  node [
    id 3
    label "3"
    cpu 33
    gpu 7
    rom 13
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 5
    rom 6
  ]
  node [
    id 5
    label "5"
    cpu 48
    gpu 13
    rom 19
  ]
  node [
    id 6
    label "6"
    cpu 8
    gpu 23
    rom 13
  ]
  node [
    id 7
    label "7"
    cpu 34
    gpu 42
    rom 26
  ]
  node [
    id 8
    label "8"
    cpu 50
    gpu 43
    rom 5
  ]
  node [
    id 9
    label "9"
    cpu 12
    gpu 50
    rom 38
  ]
  node [
    id 10
    label "10"
    cpu 43
    gpu 18
    rom 3
  ]
  node [
    id 11
    label "11"
    cpu 12
    gpu 5
    rom 40
  ]
  node [
    id 12
    label "12"
    cpu 46
    gpu 20
    rom 37
  ]
  node [
    id 13
    label "13"
    cpu 13
    gpu 3
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 0
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
  edge [
    source 3
    target 4
    bw 34
  ]
  edge [
    source 4
    target 5
    bw 17
  ]
  edge [
    source 5
    target 6
    bw 25
  ]
  edge [
    source 6
    target 7
    bw 49
  ]
  edge [
    source 7
    target 8
    bw 15
  ]
  edge [
    source 8
    target 9
    bw 27
  ]
  edge [
    source 9
    target 10
    bw 49
  ]
  edge [
    source 10
    target 11
    bw 34
  ]
  edge [
    source 11
    target 12
    bw 18
  ]
  edge [
    source 12
    target 13
    bw 26
  ]
]
