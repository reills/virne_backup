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
  id 1916
  arrival_time 42079.17324590646
  lifetime 1368.7856887741002
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 45
    gpu 41
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 12
    gpu 10
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 29
    rom 35
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 36
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 0
    gpu 10
    rom 8
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 0
    rom 2
  ]
  node [
    id 6
    label "6"
    cpu 37
    gpu 0
    rom 16
  ]
  node [
    id 7
    label "7"
    cpu 5
    gpu 48
    rom 13
  ]
  node [
    id 8
    label "8"
    cpu 34
    gpu 10
    rom 2
  ]
  node [
    id 9
    label "9"
    cpu 33
    gpu 34
    rom 9
  ]
  node [
    id 10
    label "10"
    cpu 25
    gpu 35
    rom 17
  ]
  node [
    id 11
    label "11"
    cpu 12
    gpu 43
    rom 11
  ]
  edge [
    source 0
    target 1
    bw 15
  ]
  edge [
    source 1
    target 2
    bw 24
  ]
  edge [
    source 2
    target 3
    bw 32
  ]
  edge [
    source 3
    target 4
    bw 18
  ]
  edge [
    source 4
    target 5
    bw 26
  ]
  edge [
    source 5
    target 6
    bw 25
  ]
  edge [
    source 6
    target 7
    bw 39
  ]
  edge [
    source 7
    target 8
    bw 10
  ]
  edge [
    source 8
    target 9
    bw 36
  ]
  edge [
    source 9
    target 10
    bw 25
  ]
  edge [
    source 10
    target 11
    bw 49
  ]
]
