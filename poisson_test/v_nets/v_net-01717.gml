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
  id 1717
  arrival_time 38252.04276065793
  lifetime 45.291246164171596
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 27
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 4
    gpu 49
    rom 40
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 23
    rom 9
  ]
  node [
    id 3
    label "3"
    cpu 3
    gpu 34
    rom 8
  ]
  node [
    id 4
    label "4"
    cpu 25
    gpu 8
    rom 17
  ]
  node [
    id 5
    label "5"
    cpu 9
    gpu 5
    rom 12
  ]
  node [
    id 6
    label "6"
    cpu 1
    gpu 33
    rom 18
  ]
  node [
    id 7
    label "7"
    cpu 34
    gpu 26
    rom 7
  ]
  node [
    id 8
    label "8"
    cpu 33
    gpu 4
    rom 39
  ]
  node [
    id 9
    label "9"
    cpu 49
    gpu 5
    rom 18
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 48
  ]
  edge [
    source 4
    target 5
    bw 25
  ]
  edge [
    source 5
    target 6
    bw 38
  ]
  edge [
    source 6
    target 7
    bw 19
  ]
  edge [
    source 7
    target 8
    bw 17
  ]
  edge [
    source 8
    target 9
    bw 28
  ]
]
