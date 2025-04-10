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
  id 1618
  arrival_time 36138.576168555235
  lifetime 787.4038700484031
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 1
    gpu 45
    rom 12
  ]
  node [
    id 1
    label "1"
    cpu 24
    gpu 3
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 23
    gpu 48
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 26
    gpu 24
    rom 34
  ]
  node [
    id 4
    label "4"
    cpu 45
    gpu 44
    rom 29
  ]
  node [
    id 5
    label "5"
    cpu 28
    gpu 27
    rom 41
  ]
  node [
    id 6
    label "6"
    cpu 34
    gpu 37
    rom 4
  ]
  node [
    id 7
    label "7"
    cpu 13
    gpu 9
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 20
  ]
  edge [
    source 1
    target 2
    bw 44
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
  edge [
    source 3
    target 4
    bw 17
  ]
  edge [
    source 4
    target 5
    bw 13
  ]
  edge [
    source 5
    target 6
    bw 49
  ]
  edge [
    source 6
    target 7
    bw 10
  ]
]
