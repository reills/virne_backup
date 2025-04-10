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
  id 1567
  arrival_time 35019.61962899163
  lifetime 1483.5490152126774
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 18
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 26
    gpu 6
    rom 33
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 40
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 25
    gpu 35
    rom 0
  ]
  node [
    id 4
    label "4"
    cpu 24
    gpu 26
    rom 34
  ]
  node [
    id 5
    label "5"
    cpu 10
    gpu 39
    rom 12
  ]
  node [
    id 6
    label "6"
    cpu 41
    gpu 18
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 0
  ]
  edge [
    source 1
    target 2
    bw 10
  ]
  edge [
    source 2
    target 3
    bw 23
  ]
  edge [
    source 3
    target 4
    bw 24
  ]
  edge [
    source 4
    target 5
    bw 12
  ]
  edge [
    source 5
    target 6
    bw 47
  ]
]
