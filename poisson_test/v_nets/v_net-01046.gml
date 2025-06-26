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
  id 1046
  arrival_time 22126.788584138718
  lifetime 1523.1414415042852
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 15
    gpu 22
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 33
    gpu 0
    rom 3
  ]
  node [
    id 2
    label "2"
    cpu 0
    gpu 10
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 41
    gpu 42
    rom 33
  ]
  node [
    id 4
    label "4"
    cpu 47
    gpu 29
    rom 9
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 45
    rom 19
  ]
  node [
    id 6
    label "6"
    cpu 28
    gpu 17
    rom 25
  ]
  node [
    id 7
    label "7"
    cpu 15
    gpu 6
    rom 15
  ]
  node [
    id 8
    label "8"
    cpu 3
    gpu 26
    rom 2
  ]
  node [
    id 9
    label "9"
    cpu 44
    gpu 22
    rom 36
  ]
  node [
    id 10
    label "10"
    cpu 31
    gpu 44
    rom 49
  ]
  node [
    id 11
    label "11"
    cpu 44
    gpu 8
    rom 9
  ]
  node [
    id 12
    label "12"
    cpu 46
    gpu 16
    rom 16
  ]
  node [
    id 13
    label "13"
    cpu 42
    gpu 20
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 2
  ]
  edge [
    source 3
    target 4
    bw 48
  ]
  edge [
    source 4
    target 5
    bw 34
  ]
  edge [
    source 5
    target 6
    bw 17
  ]
  edge [
    source 6
    target 7
    bw 11
  ]
  edge [
    source 7
    target 8
    bw 15
  ]
  edge [
    source 8
    target 9
    bw 39
  ]
  edge [
    source 9
    target 10
    bw 23
  ]
  edge [
    source 10
    target 11
    bw 10
  ]
  edge [
    source 11
    target 12
    bw 35
  ]
  edge [
    source 12
    target 13
    bw 16
  ]
]
