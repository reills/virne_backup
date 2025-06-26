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
  id 1445
  arrival_time 30462.47344669711
  lifetime 910.2908103612368
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 26
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 33
    gpu 27
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 34
    rom 39
  ]
  node [
    id 3
    label "3"
    cpu 20
    gpu 37
    rom 47
  ]
  node [
    id 4
    label "4"
    cpu 12
    gpu 44
    rom 37
  ]
  node [
    id 5
    label "5"
    cpu 27
    gpu 8
    rom 7
  ]
  node [
    id 6
    label "6"
    cpu 19
    gpu 36
    rom 35
  ]
  node [
    id 7
    label "7"
    cpu 15
    gpu 25
    rom 44
  ]
  node [
    id 8
    label "8"
    cpu 10
    gpu 4
    rom 29
  ]
  node [
    id 9
    label "9"
    cpu 50
    gpu 13
    rom 47
  ]
  edge [
    source 0
    target 1
    bw 40
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 23
  ]
  edge [
    source 4
    target 5
    bw 5
  ]
  edge [
    source 5
    target 6
    bw 18
  ]
  edge [
    source 6
    target 7
    bw 19
  ]
  edge [
    source 7
    target 8
    bw 16
  ]
  edge [
    source 8
    target 9
    bw 30
  ]
]
