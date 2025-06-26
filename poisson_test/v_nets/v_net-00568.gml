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
  id 568
  arrival_time 10728.261302533576
  lifetime 1425.5123585214637
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 18
    rom 21
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 1
    rom 19
  ]
  node [
    id 2
    label "2"
    cpu 43
    gpu 11
    rom 20
  ]
  node [
    id 3
    label "3"
    cpu 40
    gpu 38
    rom 30
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 33
    rom 5
  ]
  node [
    id 5
    label "5"
    cpu 47
    gpu 34
    rom 45
  ]
  node [
    id 6
    label "6"
    cpu 24
    gpu 43
    rom 20
  ]
  node [
    id 7
    label "7"
    cpu 17
    gpu 27
    rom 23
  ]
  node [
    id 8
    label "8"
    cpu 22
    gpu 26
    rom 17
  ]
  node [
    id 9
    label "9"
    cpu 39
    gpu 20
    rom 26
  ]
  node [
    id 10
    label "10"
    cpu 45
    gpu 50
    rom 10
  ]
  node [
    id 11
    label "11"
    cpu 45
    gpu 46
    rom 3
  ]
  edge [
    source 0
    target 1
    bw 34
  ]
  edge [
    source 1
    target 2
    bw 49
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
  edge [
    source 4
    target 5
    bw 18
  ]
  edge [
    source 5
    target 6
    bw 2
  ]
  edge [
    source 6
    target 7
    bw 37
  ]
  edge [
    source 7
    target 8
    bw 33
  ]
  edge [
    source 8
    target 9
    bw 16
  ]
  edge [
    source 9
    target 10
    bw 42
  ]
  edge [
    source 10
    target 11
    bw 11
  ]
]
