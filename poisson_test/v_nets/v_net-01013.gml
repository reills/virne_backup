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
  id 1013
  arrival_time 21580.16133156997
  lifetime 133.85672841054307
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 15
    rom 37
  ]
  node [
    id 1
    label "1"
    cpu 41
    gpu 36
    rom 18
  ]
  edge [
    source 0
    target 1
    bw 27
  ]
]
