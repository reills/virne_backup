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
  id 1106
  arrival_time 23022.066971260876
  lifetime 230.75221897101574
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 10
    rom 44
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 21
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 0
    gpu 16
    rom 5
  ]
  node [
    id 3
    label "3"
    cpu 30
    gpu 40
    rom 41
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 32
    rom 37
  ]
  node [
    id 5
    label "5"
    cpu 32
    gpu 16
    rom 37
  ]
  node [
    id 6
    label "6"
    cpu 36
    gpu 28
    rom 29
  ]
  node [
    id 7
    label "7"
    cpu 37
    gpu 15
    rom 35
  ]
  node [
    id 8
    label "8"
    cpu 24
    gpu 23
    rom 1
  ]
  node [
    id 9
    label "9"
    cpu 27
    gpu 14
    rom 8
  ]
  node [
    id 10
    label "10"
    cpu 7
    gpu 29
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 48
  ]
  edge [
    source 1
    target 2
    bw 31
  ]
  edge [
    source 2
    target 3
    bw 35
  ]
  edge [
    source 3
    target 4
    bw 9
  ]
  edge [
    source 4
    target 5
    bw 34
  ]
  edge [
    source 5
    target 6
    bw 15
  ]
  edge [
    source 6
    target 7
    bw 39
  ]
  edge [
    source 7
    target 8
    bw 29
  ]
  edge [
    source 8
    target 9
    bw 20
  ]
  edge [
    source 9
    target 10
    bw 12
  ]
]
