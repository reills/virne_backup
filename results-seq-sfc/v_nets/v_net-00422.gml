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
  id 422
  arrival_time 8291.288689093626
  lifetime 170.39800879619295
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 35
    rom 28
  ]
  node [
    id 1
    label "1"
    cpu 3
    gpu 27
    rom 33
  ]
  node [
    id 2
    label "2"
    cpu 7
    gpu 17
    rom 29
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 23
    rom 33
  ]
  node [
    id 4
    label "4"
    cpu 47
    gpu 7
    rom 17
  ]
  node [
    id 5
    label "5"
    cpu 5
    gpu 26
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 26
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 44
  ]
  edge [
    source 3
    target 4
    bw 26
  ]
  edge [
    source 4
    target 5
    bw 12
  ]
]
