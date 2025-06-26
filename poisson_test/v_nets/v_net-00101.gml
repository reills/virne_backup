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
  id 101
  arrival_time 1968.2449954795566
  lifetime 1920.154520426065
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 29
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 26
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 23
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 30
    gpu 13
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 27
    gpu 1
    rom 8
  ]
  node [
    id 5
    label "5"
    cpu 27
    gpu 37
    rom 18
  ]
  node [
    id 6
    label "6"
    cpu 28
    gpu 43
    rom 9
  ]
  node [
    id 7
    label "7"
    cpu 13
    gpu 26
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 17
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 10
  ]
  edge [
    source 3
    target 4
    bw 24
  ]
  edge [
    source 4
    target 5
    bw 5
  ]
  edge [
    source 5
    target 6
    bw 47
  ]
  edge [
    source 6
    target 7
    bw 41
  ]
]
