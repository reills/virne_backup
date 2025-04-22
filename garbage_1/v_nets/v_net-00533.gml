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
  id 533
  arrival_time 10163.644620504643
  lifetime 386.09346586146387
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 29
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 2
    gpu 0
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 15
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 6
    gpu 17
    rom 19
  ]
  node [
    id 4
    label "4"
    cpu 12
    gpu 27
    rom 42
  ]
  node [
    id 5
    label "5"
    cpu 29
    gpu 32
    rom 14
  ]
  node [
    id 6
    label "6"
    cpu 2
    gpu 31
    rom 49
  ]
  node [
    id 7
    label "7"
    cpu 35
    gpu 40
    rom 4
  ]
  node [
    id 8
    label "8"
    cpu 32
    gpu 33
    rom 7
  ]
  node [
    id 9
    label "9"
    cpu 20
    gpu 40
    rom 8
  ]
  edge [
    source 0
    target 1
    bw 31
  ]
  edge [
    source 1
    target 2
    bw 42
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
  edge [
    source 3
    target 4
    bw 5
  ]
  edge [
    source 4
    target 5
    bw 37
  ]
  edge [
    source 5
    target 6
    bw 29
  ]
  edge [
    source 6
    target 7
    bw 14
  ]
  edge [
    source 7
    target 8
    bw 17
  ]
  edge [
    source 8
    target 9
    bw 29
  ]
]
