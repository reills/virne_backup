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
  id 904
  arrival_time 19341.275713077302
  lifetime 2447.731949935989
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 33
    gpu 6
    rom 9
  ]
  node [
    id 1
    label "1"
    cpu 12
    gpu 24
    rom 40
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 30
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 34
    gpu 43
    rom 1
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 27
    rom 50
  ]
  node [
    id 5
    label "5"
    cpu 30
    gpu 37
    rom 25
  ]
  node [
    id 6
    label "6"
    cpu 13
    gpu 40
    rom 41
  ]
  node [
    id 7
    label "7"
    cpu 40
    gpu 11
    rom 10
  ]
  edge [
    source 0
    target 1
    bw 4
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
  edge [
    source 2
    target 3
    bw 38
  ]
  edge [
    source 3
    target 4
    bw 29
  ]
  edge [
    source 4
    target 5
    bw 45
  ]
  edge [
    source 5
    target 6
    bw 26
  ]
  edge [
    source 6
    target 7
    bw 20
  ]
]
