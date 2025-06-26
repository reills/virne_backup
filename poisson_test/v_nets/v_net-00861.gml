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
  id 861
  arrival_time 18055.868745961903
  lifetime 947.5491459432917
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 13
    rom 49
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 32
    rom 15
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 49
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 40
    rom 9
  ]
  node [
    id 4
    label "4"
    cpu 45
    gpu 47
    rom 14
  ]
  node [
    id 5
    label "5"
    cpu 27
    gpu 1
    rom 16
  ]
  node [
    id 6
    label "6"
    cpu 30
    gpu 27
    rom 18
  ]
  node [
    id 7
    label "7"
    cpu 13
    gpu 7
    rom 12
  ]
  node [
    id 8
    label "8"
    cpu 30
    gpu 21
    rom 4
  ]
  node [
    id 9
    label "9"
    cpu 41
    gpu 43
    rom 22
  ]
  node [
    id 10
    label "10"
    cpu 11
    gpu 6
    rom 21
  ]
  node [
    id 11
    label "11"
    cpu 44
    gpu 32
    rom 39
  ]
  node [
    id 12
    label "12"
    cpu 21
    gpu 28
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 11
  ]
  edge [
    source 1
    target 2
    bw 47
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
    bw 7
  ]
  edge [
    source 5
    target 6
    bw 42
  ]
  edge [
    source 6
    target 7
    bw 37
  ]
  edge [
    source 7
    target 8
    bw 24
  ]
  edge [
    source 8
    target 9
    bw 29
  ]
  edge [
    source 9
    target 10
    bw 29
  ]
  edge [
    source 10
    target 11
    bw 8
  ]
  edge [
    source 11
    target 12
    bw 50
  ]
]
