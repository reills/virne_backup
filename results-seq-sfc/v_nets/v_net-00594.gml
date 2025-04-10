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
  id 594
  arrival_time 12253.571226756621
  lifetime 1172.6093522831934
  num_nodes 13
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 22
    rom 24
  ]
  node [
    id 1
    label "1"
    cpu 9
    gpu 24
    rom 15
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 41
    rom 30
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 36
    rom 33
  ]
  node [
    id 4
    label "4"
    cpu 24
    gpu 21
    rom 4
  ]
  node [
    id 5
    label "5"
    cpu 29
    gpu 10
    rom 46
  ]
  node [
    id 6
    label "6"
    cpu 33
    gpu 32
    rom 35
  ]
  node [
    id 7
    label "7"
    cpu 24
    gpu 34
    rom 23
  ]
  node [
    id 8
    label "8"
    cpu 30
    gpu 28
    rom 16
  ]
  node [
    id 9
    label "9"
    cpu 45
    gpu 33
    rom 44
  ]
  node [
    id 10
    label "10"
    cpu 3
    gpu 34
    rom 37
  ]
  node [
    id 11
    label "11"
    cpu 29
    gpu 19
    rom 47
  ]
  node [
    id 12
    label "12"
    cpu 34
    gpu 6
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 38
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 23
  ]
  edge [
    source 3
    target 4
    bw 14
  ]
  edge [
    source 4
    target 5
    bw 32
  ]
  edge [
    source 5
    target 6
    bw 14
  ]
  edge [
    source 6
    target 7
    bw 30
  ]
  edge [
    source 7
    target 8
    bw 21
  ]
  edge [
    source 8
    target 9
    bw 16
  ]
  edge [
    source 9
    target 10
    bw 36
  ]
  edge [
    source 10
    target 11
    bw 41
  ]
  edge [
    source 11
    target 12
    bw 40
  ]
]
