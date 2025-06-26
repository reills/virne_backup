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
  id 1665
  arrival_time 37180.3951334683
  lifetime 1279.7292937124919
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 20
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 2
    rom 30
  ]
  node [
    id 2
    label "2"
    cpu 19
    gpu 25
    rom 14
  ]
  node [
    id 3
    label "3"
    cpu 22
    gpu 46
    rom 17
  ]
  node [
    id 4
    label "4"
    cpu 39
    gpu 37
    rom 0
  ]
  node [
    id 5
    label "5"
    cpu 1
    gpu 9
    rom 5
  ]
  node [
    id 6
    label "6"
    cpu 0
    gpu 43
    rom 41
  ]
  node [
    id 7
    label "7"
    cpu 26
    gpu 45
    rom 36
  ]
  node [
    id 8
    label "8"
    cpu 5
    gpu 14
    rom 20
  ]
  node [
    id 9
    label "9"
    cpu 31
    gpu 46
    rom 5
  ]
  node [
    id 10
    label "10"
    cpu 10
    gpu 44
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 0
  ]
  edge [
    source 1
    target 2
    bw 17
  ]
  edge [
    source 2
    target 3
    bw 9
  ]
  edge [
    source 3
    target 4
    bw 1
  ]
  edge [
    source 4
    target 5
    bw 9
  ]
  edge [
    source 5
    target 6
    bw 34
  ]
  edge [
    source 6
    target 7
    bw 49
  ]
  edge [
    source 7
    target 8
    bw 29
  ]
  edge [
    source 8
    target 9
    bw 35
  ]
  edge [
    source 9
    target 10
    bw 33
  ]
]
