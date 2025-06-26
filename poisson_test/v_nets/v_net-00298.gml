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
  id 298
  arrival_time 5748.766193412575
  lifetime 3935.08003982759
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 31
    rom 41
  ]
  node [
    id 1
    label "1"
    cpu 17
    gpu 30
    rom 43
  ]
  node [
    id 2
    label "2"
    cpu 41
    gpu 0
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 33
    gpu 5
    rom 27
  ]
  node [
    id 4
    label "4"
    cpu 12
    gpu 30
    rom 9
  ]
  node [
    id 5
    label "5"
    cpu 8
    gpu 21
    rom 23
  ]
  node [
    id 6
    label "6"
    cpu 40
    gpu 49
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 23
  ]
  edge [
    source 1
    target 2
    bw 28
  ]
  edge [
    source 2
    target 3
    bw 33
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
    bw 8
  ]
]
