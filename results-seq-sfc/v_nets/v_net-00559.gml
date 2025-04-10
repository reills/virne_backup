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
  id 559
  arrival_time 10535.729453888476
  lifetime 4007.8336036108562
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 5
    gpu 36
    rom 30
  ]
  node [
    id 1
    label "1"
    cpu 6
    gpu 37
    rom 33
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 22
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 28
    rom 38
  ]
  node [
    id 4
    label "4"
    cpu 0
    gpu 27
    rom 48
  ]
  node [
    id 5
    label "5"
    cpu 28
    gpu 34
    rom 26
  ]
  node [
    id 6
    label "6"
    cpu 35
    gpu 27
    rom 39
  ]
  node [
    id 7
    label "7"
    cpu 44
    gpu 27
    rom 31
  ]
  edge [
    source 0
    target 1
    bw 16
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 7
  ]
  edge [
    source 3
    target 4
    bw 38
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
    bw 41
  ]
]
