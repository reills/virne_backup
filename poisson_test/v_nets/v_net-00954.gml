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
  id 954
  arrival_time 20369.00464259951
  lifetime 1589.4975720495809
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 30
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 45
    gpu 48
    rom 14
  ]
  node [
    id 2
    label "2"
    cpu 43
    gpu 6
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 19
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 35
    gpu 27
    rom 16
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 3
    rom 29
  ]
  node [
    id 6
    label "6"
    cpu 17
    gpu 8
    rom 47
  ]
  node [
    id 7
    label "7"
    cpu 4
    gpu 27
    rom 48
  ]
  node [
    id 8
    label "8"
    cpu 38
    gpu 7
    rom 29
  ]
  node [
    id 9
    label "9"
    cpu 37
    gpu 6
    rom 20
  ]
  node [
    id 10
    label "10"
    cpu 27
    gpu 1
    rom 36
  ]
  node [
    id 11
    label "11"
    cpu 35
    gpu 31
    rom 41
  ]
  node [
    id 12
    label "12"
    cpu 39
    gpu 30
    rom 24
  ]
  edge [
    source 0
    target 1
    bw 38
  ]
  edge [
    source 1
    target 2
    bw 1
  ]
  edge [
    source 2
    target 3
    bw 8
  ]
  edge [
    source 3
    target 4
    bw 5
  ]
  edge [
    source 4
    target 5
    bw 19
  ]
  edge [
    source 5
    target 6
    bw 12
  ]
  edge [
    source 6
    target 7
    bw 24
  ]
  edge [
    source 7
    target 8
    bw 36
  ]
  edge [
    source 8
    target 9
    bw 1
  ]
  edge [
    source 9
    target 10
    bw 39
  ]
  edge [
    source 10
    target 11
    bw 20
  ]
  edge [
    source 11
    target 12
    bw 22
  ]
]
