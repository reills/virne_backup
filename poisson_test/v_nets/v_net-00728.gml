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
  id 728
  arrival_time 15336.27186076354
  lifetime 4061.4828378506454
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 23
    gpu 37
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 24
    gpu 34
    rom 27
  ]
  node [
    id 2
    label "2"
    cpu 8
    gpu 8
    rom 42
  ]
  node [
    id 3
    label "3"
    cpu 31
    gpu 12
    rom 33
  ]
  node [
    id 4
    label "4"
    cpu 15
    gpu 0
    rom 13
  ]
  node [
    id 5
    label "5"
    cpu 29
    gpu 30
    rom 1
  ]
  node [
    id 6
    label "6"
    cpu 7
    gpu 12
    rom 20
  ]
  node [
    id 7
    label "7"
    cpu 3
    gpu 5
    rom 45
  ]
  node [
    id 8
    label "8"
    cpu 9
    gpu 6
    rom 22
  ]
  node [
    id 9
    label "9"
    cpu 50
    gpu 9
    rom 46
  ]
  node [
    id 10
    label "10"
    cpu 4
    gpu 41
    rom 29
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 16
  ]
  edge [
    source 3
    target 4
    bw 14
  ]
  edge [
    source 4
    target 5
    bw 26
  ]
  edge [
    source 5
    target 6
    bw 13
  ]
  edge [
    source 6
    target 7
    bw 6
  ]
  edge [
    source 7
    target 8
    bw 9
  ]
  edge [
    source 8
    target 9
    bw 35
  ]
  edge [
    source 9
    target 10
    bw 30
  ]
]
