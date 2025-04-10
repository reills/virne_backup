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
  id 19
  arrival_time 521.5744484791431
  lifetime 545.8015266172866
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 24
    gpu 13
    rom 36
  ]
  node [
    id 1
    label "1"
    cpu 21
    gpu 28
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 3
    rom 3
  ]
  node [
    id 3
    label "3"
    cpu 24
    gpu 40
    rom 4
  ]
  node [
    id 4
    label "4"
    cpu 13
    gpu 6
    rom 47
  ]
  node [
    id 5
    label "5"
    cpu 25
    gpu 3
    rom 19
  ]
  node [
    id 6
    label "6"
    cpu 31
    gpu 47
    rom 23
  ]
  node [
    id 7
    label "7"
    cpu 49
    gpu 31
    rom 10
  ]
  node [
    id 8
    label "8"
    cpu 3
    gpu 19
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 21
  ]
  edge [
    source 1
    target 2
    bw 36
  ]
  edge [
    source 2
    target 3
    bw 43
  ]
  edge [
    source 3
    target 4
    bw 5
  ]
  edge [
    source 4
    target 5
    bw 26
  ]
  edge [
    source 5
    target 6
    bw 46
  ]
  edge [
    source 6
    target 7
    bw 28
  ]
  edge [
    source 7
    target 8
    bw 27
  ]
]
