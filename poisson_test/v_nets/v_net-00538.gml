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
  id 538
  arrival_time 10239.06110659727
  lifetime 272.1613775749403
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 31
    gpu 6
    rom 40
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 43
    rom 34
  ]
  node [
    id 2
    label "2"
    cpu 23
    gpu 0
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 40
    gpu 48
    rom 0
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 9
    rom 6
  ]
  node [
    id 5
    label "5"
    cpu 5
    gpu 35
    rom 23
  ]
  node [
    id 6
    label "6"
    cpu 29
    gpu 17
    rom 34
  ]
  node [
    id 7
    label "7"
    cpu 6
    gpu 41
    rom 10
  ]
  node [
    id 8
    label "8"
    cpu 1
    gpu 45
    rom 43
  ]
  node [
    id 9
    label "9"
    cpu 19
    gpu 17
    rom 39
  ]
  edge [
    source 0
    target 1
    bw 37
  ]
  edge [
    source 1
    target 2
    bw 3
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 20
  ]
  edge [
    source 4
    target 5
    bw 3
  ]
  edge [
    source 5
    target 6
    bw 18
  ]
  edge [
    source 6
    target 7
    bw 30
  ]
  edge [
    source 7
    target 8
    bw 18
  ]
  edge [
    source 8
    target 9
    bw 50
  ]
]
