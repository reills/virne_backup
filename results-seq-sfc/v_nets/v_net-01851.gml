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
  id 1851
  arrival_time 40835.422674897905
  lifetime 708.0891607384035
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 10
    rom 4
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 18
    rom 13
  ]
  node [
    id 2
    label "2"
    cpu 10
    gpu 11
    rom 8
  ]
  node [
    id 3
    label "3"
    cpu 41
    gpu 20
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 38
    gpu 34
    rom 44
  ]
  node [
    id 5
    label "5"
    cpu 21
    gpu 13
    rom 23
  ]
  node [
    id 6
    label "6"
    cpu 34
    gpu 6
    rom 17
  ]
  node [
    id 7
    label "7"
    cpu 26
    gpu 48
    rom 25
  ]
  node [
    id 8
    label "8"
    cpu 38
    gpu 3
    rom 40
  ]
  node [
    id 9
    label "9"
    cpu 21
    gpu 23
    rom 15
  ]
  node [
    id 10
    label "10"
    cpu 28
    gpu 35
    rom 11
  ]
  node [
    id 11
    label "11"
    cpu 7
    gpu 12
    rom 43
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 2
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 21
  ]
  edge [
    source 5
    target 6
    bw 36
  ]
  edge [
    source 6
    target 7
    bw 11
  ]
  edge [
    source 7
    target 8
    bw 27
  ]
  edge [
    source 8
    target 9
    bw 15
  ]
  edge [
    source 9
    target 10
    bw 40
  ]
  edge [
    source 10
    target 11
    bw 39
  ]
]
