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
  id 1152
  arrival_time 23975.806080661732
  lifetime 1929.002900472898
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 48
    rom 35
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 3
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 39
    gpu 13
    rom 44
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 8
    rom 38
  ]
  node [
    id 4
    label "4"
    cpu 50
    gpu 44
    rom 37
  ]
  node [
    id 5
    label "5"
    cpu 26
    gpu 9
    rom 22
  ]
  node [
    id 6
    label "6"
    cpu 3
    gpu 8
    rom 48
  ]
  node [
    id 7
    label "7"
    cpu 6
    gpu 44
    rom 40
  ]
  node [
    id 8
    label "8"
    cpu 35
    gpu 35
    rom 19
  ]
  node [
    id 9
    label "9"
    cpu 1
    gpu 38
    rom 49
  ]
  node [
    id 10
    label "10"
    cpu 47
    gpu 44
    rom 13
  ]
  edge [
    source 0
    target 1
    bw 2
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
  edge [
    source 2
    target 3
    bw 47
  ]
  edge [
    source 3
    target 4
    bw 9
  ]
  edge [
    source 4
    target 5
    bw 2
  ]
  edge [
    source 5
    target 6
    bw 31
  ]
  edge [
    source 6
    target 7
    bw 33
  ]
  edge [
    source 7
    target 8
    bw 25
  ]
  edge [
    source 8
    target 9
    bw 12
  ]
  edge [
    source 9
    target 10
    bw 35
  ]
]
