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
  id 1150
  arrival_time 23971.126164569258
  lifetime 7.964095563312664
  num_nodes 15
  type "path"
  node [
    id 0
    label "0"
    cpu 10
    gpu 1
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 18
    gpu 20
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 15
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 14
    gpu 0
    rom 4
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 42
    rom 20
  ]
  node [
    id 5
    label "5"
    cpu 37
    gpu 6
    rom 14
  ]
  node [
    id 6
    label "6"
    cpu 41
    gpu 5
    rom 48
  ]
  node [
    id 7
    label "7"
    cpu 16
    gpu 17
    rom 31
  ]
  node [
    id 8
    label "8"
    cpu 1
    gpu 24
    rom 15
  ]
  node [
    id 9
    label "9"
    cpu 43
    gpu 41
    rom 45
  ]
  node [
    id 10
    label "10"
    cpu 47
    gpu 41
    rom 35
  ]
  node [
    id 11
    label "11"
    cpu 9
    gpu 11
    rom 27
  ]
  node [
    id 12
    label "12"
    cpu 45
    gpu 7
    rom 20
  ]
  node [
    id 13
    label "13"
    cpu 36
    gpu 9
    rom 49
  ]
  node [
    id 14
    label "14"
    cpu 31
    gpu 2
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
  edge [
    source 4
    target 5
    bw 13
  ]
  edge [
    source 5
    target 6
    bw 32
  ]
  edge [
    source 6
    target 7
    bw 33
  ]
  edge [
    source 7
    target 8
    bw 5
  ]
  edge [
    source 8
    target 9
    bw 15
  ]
  edge [
    source 9
    target 10
    bw 18
  ]
  edge [
    source 10
    target 11
    bw 10
  ]
  edge [
    source 11
    target 12
    bw 49
  ]
  edge [
    source 12
    target 13
    bw 32
  ]
  edge [
    source 13
    target 14
    bw 14
  ]
]
