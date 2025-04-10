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
  id 1255
  arrival_time 25918.04728862628
  lifetime 607.0892634005469
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 14
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 29
    rom 32
  ]
  node [
    id 2
    label "2"
    cpu 37
    gpu 48
    rom 7
  ]
  node [
    id 3
    label "3"
    cpu 37
    gpu 36
    rom 48
  ]
  node [
    id 4
    label "4"
    cpu 8
    gpu 13
    rom 10
  ]
  node [
    id 5
    label "5"
    cpu 14
    gpu 30
    rom 4
  ]
  node [
    id 6
    label "6"
    cpu 9
    gpu 39
    rom 23
  ]
  node [
    id 7
    label "7"
    cpu 39
    gpu 26
    rom 1
  ]
  node [
    id 8
    label "8"
    cpu 39
    gpu 41
    rom 28
  ]
  node [
    id 9
    label "9"
    cpu 34
    gpu 21
    rom 20
  ]
  node [
    id 10
    label "10"
    cpu 19
    gpu 23
    rom 6
  ]
  node [
    id 11
    label "11"
    cpu 0
    gpu 47
    rom 45
  ]
  node [
    id 12
    label "12"
    cpu 6
    gpu 42
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 33
  ]
  edge [
    source 1
    target 2
    bw 43
  ]
  edge [
    source 2
    target 3
    bw 12
  ]
  edge [
    source 3
    target 4
    bw 3
  ]
  edge [
    source 4
    target 5
    bw 47
  ]
  edge [
    source 5
    target 6
    bw 26
  ]
  edge [
    source 6
    target 7
    bw 2
  ]
  edge [
    source 7
    target 8
    bw 25
  ]
  edge [
    source 8
    target 9
    bw 26
  ]
  edge [
    source 9
    target 10
    bw 39
  ]
  edge [
    source 10
    target 11
    bw 19
  ]
  edge [
    source 11
    target 12
    bw 1
  ]
]
