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
  id 400
  arrival_time 7861.900029352817
  lifetime 287.01052749114893
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 50
    rom 36
  ]
  node [
    id 1
    label "1"
    cpu 17
    gpu 31
    rom 44
  ]
  node [
    id 2
    label "2"
    cpu 11
    gpu 7
    rom 5
  ]
  node [
    id 3
    label "3"
    cpu 46
    gpu 0
    rom 50
  ]
  node [
    id 4
    label "4"
    cpu 1
    gpu 24
    rom 42
  ]
  node [
    id 5
    label "5"
    cpu 28
    gpu 17
    rom 38
  ]
  node [
    id 6
    label "6"
    cpu 32
    gpu 1
    rom 20
  ]
  node [
    id 7
    label "7"
    cpu 46
    gpu 14
    rom 37
  ]
  node [
    id 8
    label "8"
    cpu 6
    gpu 41
    rom 1
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 20
  ]
  edge [
    source 2
    target 3
    bw 50
  ]
  edge [
    source 3
    target 4
    bw 48
  ]
  edge [
    source 4
    target 5
    bw 50
  ]
  edge [
    source 5
    target 6
    bw 50
  ]
  edge [
    source 6
    target 7
    bw 37
  ]
  edge [
    source 7
    target 8
    bw 33
  ]
]
