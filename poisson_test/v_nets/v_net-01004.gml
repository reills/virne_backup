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
  id 1004
  arrival_time 21514.18549379988
  lifetime 1508.03801032565
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 44
    rom 36
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 38
    rom 11
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 44
    rom 13
  ]
  node [
    id 3
    label "3"
    cpu 31
    gpu 49
    rom 36
  ]
  node [
    id 4
    label "4"
    cpu 4
    gpu 25
    rom 9
  ]
  node [
    id 5
    label "5"
    cpu 30
    gpu 7
    rom 18
  ]
  node [
    id 6
    label "6"
    cpu 49
    gpu 46
    rom 2
  ]
  node [
    id 7
    label "7"
    cpu 36
    gpu 50
    rom 33
  ]
  node [
    id 8
    label "8"
    cpu 48
    gpu 8
    rom 42
  ]
  node [
    id 9
    label "9"
    cpu 35
    gpu 40
    rom 49
  ]
  node [
    id 10
    label "10"
    cpu 50
    gpu 3
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 2
  ]
  edge [
    source 1
    target 2
    bw 38
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
  edge [
    source 3
    target 4
    bw 10
  ]
  edge [
    source 4
    target 5
    bw 50
  ]
  edge [
    source 5
    target 6
    bw 40
  ]
  edge [
    source 6
    target 7
    bw 28
  ]
  edge [
    source 7
    target 8
    bw 40
  ]
  edge [
    source 8
    target 9
    bw 24
  ]
  edge [
    source 9
    target 10
    bw 25
  ]
]
