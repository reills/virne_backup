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
  id 420
  arrival_time 8254.656219852792
  lifetime 635.1854566825479
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 28
    rom 44
  ]
  node [
    id 1
    label "1"
    cpu 21
    gpu 24
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 33
    gpu 6
    rom 49
  ]
  node [
    id 3
    label "3"
    cpu 40
    gpu 26
    rom 1
  ]
  node [
    id 4
    label "4"
    cpu 45
    gpu 10
    rom 2
  ]
  node [
    id 5
    label "5"
    cpu 2
    gpu 11
    rom 35
  ]
  node [
    id 6
    label "6"
    cpu 43
    gpu 32
    rom 20
  ]
  node [
    id 7
    label "7"
    cpu 21
    gpu 8
    rom 18
  ]
  node [
    id 8
    label "8"
    cpu 49
    gpu 19
    rom 37
  ]
  node [
    id 9
    label "9"
    cpu 43
    gpu 7
    rom 1
  ]
  node [
    id 10
    label "10"
    cpu 38
    gpu 21
    rom 36
  ]
  node [
    id 11
    label "11"
    cpu 9
    gpu 31
    rom 42
  ]
  node [
    id 12
    label "12"
    cpu 45
    gpu 26
    rom 2
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 1
    target 2
    bw 17
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 3
  ]
  edge [
    source 4
    target 5
    bw 20
  ]
  edge [
    source 5
    target 6
    bw 0
  ]
  edge [
    source 6
    target 7
    bw 5
  ]
  edge [
    source 7
    target 8
    bw 30
  ]
  edge [
    source 8
    target 9
    bw 17
  ]
  edge [
    source 9
    target 10
    bw 7
  ]
  edge [
    source 10
    target 11
    bw 29
  ]
  edge [
    source 11
    target 12
    bw 41
  ]
]
