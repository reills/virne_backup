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
  id 1597
  arrival_time 35865.369789022625
  lifetime 56.415285644132354
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 1
    gpu 39
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 45
    rom 16
  ]
  node [
    id 2
    label "2"
    cpu 43
    gpu 25
    rom 34
  ]
  node [
    id 3
    label "3"
    cpu 15
    gpu 47
    rom 4
  ]
  node [
    id 4
    label "4"
    cpu 39
    gpu 5
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 35
    gpu 30
    rom 29
  ]
  node [
    id 6
    label "6"
    cpu 0
    gpu 3
    rom 0
  ]
  node [
    id 7
    label "7"
    cpu 49
    gpu 22
    rom 41
  ]
  node [
    id 8
    label "8"
    cpu 10
    gpu 16
    rom 12
  ]
  node [
    id 9
    label "9"
    cpu 44
    gpu 31
    rom 49
  ]
  node [
    id 10
    label "10"
    cpu 5
    gpu 5
    rom 23
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 44
  ]
  edge [
    source 2
    target 3
    bw 45
  ]
  edge [
    source 3
    target 4
    bw 22
  ]
  edge [
    source 4
    target 5
    bw 47
  ]
  edge [
    source 5
    target 6
    bw 14
  ]
  edge [
    source 6
    target 7
    bw 45
  ]
  edge [
    source 7
    target 8
    bw 16
  ]
  edge [
    source 8
    target 9
    bw 18
  ]
  edge [
    source 9
    target 10
    bw 15
  ]
]
